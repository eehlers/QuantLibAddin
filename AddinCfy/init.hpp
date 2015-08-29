
#ifndef addincfy_init_hpp
#define addincfy_init_hpp

void initializeAddin();

#define COUNTIFY_API __attribute__((visibility("default")))

#define RP_LOG_MESSAGE(function, message) \
do { \
    std::cout << "REPOSIT - " << function << " - " << message << std::endl; \
} while (false)

#endif

