#include "last_year.hpp"
#include <httpserver.hpp>
#include <iostream>

using namespace httpserver;

class hello_world_resource : public http_resource {
public:
  std::shared_ptr<http_response> render(const http_request &req) {
    const std::string_view path = req.get_path();
    std::cout << "Path: " << path << std::endl;
    return std::shared_ptr<http_response>(new string_response("Hello, World!"));
  }
};

int main(int argc, char **argv) {
  std::vector<std::string> args = std::vector<std::string>(argv, argv + argc);
  for (std::string &arg : args) {
    std::cout << "Arg: " << arg << std::endl;
  }
  std::cout << "Starting server on port 8080" << std::endl;
  webserver ws = create_webserver(8080);

  hello_world_resource hwr;
  LastYear last_year;
  ws.register_resource("/hello", &hwr);
  ws.register_resource("/last_year", &last_year);
  ws.start(true);

  return 0;
}
