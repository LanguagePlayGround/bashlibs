set(CPACK_PACKAGE_VERSION_MAJOR ${APP_VER_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${APP_VER_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${APP_VER_PATCH})
set(CPACK_SOURCE_GENERATOR TBZ2)

# for ubuntu
set(CPACK_GENERATOR DEB)
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Kfir Lavi") #required

include(CPack)