#pragma once
#include "httpserver.hpp"

namespace h = httpserver;

class LastYear : public h::http_resource {
public:
  LastYear() = default;

  std::shared_ptr<h::http_response> render(const h::http_request &req);
};
