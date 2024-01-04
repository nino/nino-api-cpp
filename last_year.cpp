#include "last_year.hpp"
#include <sstream>

namespace h = httpserver;

std::shared_ptr<h::http_response> LastYear::render(const h::http_request &req) {
  auto name = req.get_arg("name");
  auto message = std::stringstream();
  message << "Hello, ";
  if (name.get_flat_value() != "") {
    message << name.get_flat_value();
  } else {
    message << "Nino";
  }
  return std::shared_ptr<h::http_response>(
      new h::string_response(message.str()));
}
