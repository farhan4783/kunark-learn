#include "my_application.h"

int main(int argc, char** argv) {
  g_autoptr(MyApplication) app = my_application_new();
  g_autoptr(MyApplication) app =
      my_application_new("com.example.rural_learning_app", G_APPLICATION_NON_UNIQUE);
  return g_application_run(G_APPLICATION(app), argc, argv);
}
