#pragma once
#include <boost/outcome.hpp>
namespace outcome = BOOST_OUTCOME_V2_NAMESPACE;

namespace http {

enum class HttpError {
  SomethingWentWrong = 0,
};

outcome::result<std::string, HttpError>
get_file(const std::string host, const std::string path) noexcept;

} // namespace http
