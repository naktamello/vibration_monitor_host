#include <iostream>
#include <locale>
#include <codecvt>
#include <libusb-1.0/libusb.h>
#include <boost/iostreams/device/file.hpp>
#include <boost/iostreams/stream.hpp>
//#include <boost/log/sinks/text_file_backend.hpp>
//#include <boost/interprocess/streams/bufferstream.hpp>
#include <boost/make_shared.hpp>
#include <boost/format.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

#define VENDOR_ID 0x0483
#define PRODUCT_ID 0x5740
#define BUF_SIZE   2048
#define ENDPOINT_IN 0x81
#define ENDPOINT_OUT 0x01

unsigned char rxbuf[BUF_SIZE] = {0};

libusb_device_handle *devh = nullptr;
libusb_context *ctx = nullptr;
libusb_transfer *transfer_in;
//boost::iostreams::stream_buffer<boost::iostreams::file_sink> *p_fout;
//std::shared_ptr<std::ostream> f_stream;
//std::ostream* f_stream;
//std::shared_ptr<std::wstring_convert<convert_type, wchar_t>> converter;
static constexpr uint32_t FILESIZE = 1*1024*1024;


class RotatingFile {
    using FileSink = boost::iostreams::stream_buffer<boost::iostreams::file_sink>;
public:
    explicit RotatingFile(uint32_t filesize):filesize_(filesize), bytes_cnt_(0){
        setup_file_stream();
        std::cout<<"constructing RotatingFile" << std::endl;
    }
    void write_buffer_to_file(const uint8_t* buf, size_t len){
        for (size_t i = 0; i < len; ++i) {
            *out_stream_ << buf[i];
        }
        bytes_cnt_+=len;
        if (bytes_cnt_ >= filesize_){
            std::cout<< "setting up new file" << std::endl;
            setup_file_stream();
        }
    }

protected:
    uint32_t filesize_;
    uint32_t bytes_cnt_;
    using convert_type = std::codecvt_utf8<wchar_t>;
    std::shared_ptr<boost::iostreams::stream_buffer<boost::iostreams::file_sink>> file_sink_;
    std::unique_ptr<std::ostream> out_stream_;
    std::wstring_convert<convert_type, wchar_t> converter;

    std::string format_time(boost::posix_time::ptime now) {
        static std::locale loc(std::wcout.getloc(), new boost::posix_time::wtime_facet(L"%Y-%m-%dT%H:%M:%S"));
        std::basic_stringstream<wchar_t> ss;
        ss.imbue(loc);
        ss << now;
        return converter.to_bytes(ss.str());
    }

    void setup_file_stream(){
        bytes_cnt_ = 0;
        if (file_sink_)
            file_sink_ = nullptr;
        if (out_stream_)
            out_stream_ = nullptr;
        file_sink_ = std::make_shared<FileSink>(format_time(get_now()) + ".vib");
        file_sink_->set_auto_close(true);
        out_stream_ = std::make_unique<std::ostream>(file_sink_.get());

    }

    boost::posix_time::ptime get_now(){
        return boost::posix_time::second_clock::local_time();
    }
};

std::shared_ptr<RotatingFile> output_file;

void cb_in(libusb_transfer *transfer) {
//    std::cout << "in callback!" << std::endl;

    output_file->write_buffer_to_file(transfer->buffer, (size_t) transfer->actual_length);
//    for (size_t i = 0; i < transfer->actual_length; ++i) {
//        *f_stream << transfer->buffer[i];
//    }

    libusb_submit_transfer(transfer);
}


int main() {

    output_file = std::make_shared<RotatingFile>(FILESIZE);

    int result;

    result = libusb_init(nullptr);
    if (result < 0) {
        std::cout << "libusb_init error" << std::endl;
        return 1;
    }

//    libusb_set_debug(nullptr, 3);
    devh = libusb_open_device_with_vid_pid(nullptr, VENDOR_ID, PRODUCT_ID);
    if (!devh) {
        std::cout << "could not find the usb device" << std::endl;
        return 1;
    }

    libusb_detach_kernel_driver(devh, 1);

    result = libusb_claim_interface(devh, 1);
    if (result < 0) {
        std::cout << "could not claim the interface" << std::endl;
        return 1;
    }

    transfer_in = libusb_alloc_transfer(0);
    libusb_fill_bulk_transfer(transfer_in, devh, ENDPOINT_IN, rxbuf, BUF_SIZE, cb_in, nullptr, 0);
    result = libusb_submit_transfer(transfer_in);
    while (true) {
        result = libusb_handle_events_completed(ctx, nullptr);
    }
    return 0;
}