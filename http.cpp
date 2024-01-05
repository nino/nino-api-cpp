#define CPPHTTPLIB_OPENSSL_SUPPORT
#include "http.hpp"
#include "deps/httplib.h"
#include <boost/outcome.hpp>
namespace outcome = BOOST_OUTCOME_V2_NAMESPACE;

outcome::result<std::string, http::HttpError>
http::get_file(const std::string host, const std::string path) noexcept {
  try {
    httplib::Client client(host);
    auto res = client.Get(path.c_str());
    return res->body;
  } catch (const std::exception &e) {
    return HttpError::SomethingWentWrong;
  }
}
