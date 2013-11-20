#!/bin/bash
$(bashlibs --load-base)
include shunit2_enhancements.sh
include os_detection.sh

create_ubuntu_lsb_release_file() {
    local filename=$1

	cat <<- EOF > $DISTRO_FILE
	DISTRIB_ID=Ubuntu
	DISTRIB_RELEASE=12.10
	DISTRIB_CODENAME=quantal
	DISTRIB_DESCRIPTION="Ubuntu 12.10"
	EOF
}

oneTimeSetUp() {
    DISTRO_FILE=/tmp/lsb-release

    create_ubuntu_lsb_release_file \
        $DISTRO_FILE
}

oneTimeTearDown() {
    [[ -f $DISTRO_FILE ]] \
        && rm -f $DISTRO_FILE
}

set_distro_file() {
    ubuntu_release_file() {
        echo /tmp/lsb-release
    }
}

set_distro_file_to_none() {
    ubuntu_release_file() {
        echo non_exist_file
    }
}

test_is_ubuntu() {
    set_distro_file
    return_true "is_ubuntu"

    set_distro_file_to_none
    return_false "is_ubuntu"
}

test_ubuntu_version() {
    set_distro_file
    returns '12.10' "ubuntu_version"

    set_distro_file_to_none
    returns_empty "ubuntu_version"
}

test_ubuntu_version_msb() {
    returns 12 "ubuntu_version_msb 12.04"

}

test_ubuntu_version_lsb() {
    returns 04 "ubuntu_version_lsb 12.04"

}

test_is_ubuntu_version_equal_to() {
    set_distro_file
    return_true "is_ubuntu_version_equal_to 12.10"
    return_false "is_ubuntu_version_equal_to 9.04"
}

test_is_ubuntu_newer_then() {
    return_true "is_ubuntu_newer_then 9.04 $DISTRO_FILE"
    return_true "is_ubuntu_newer_then 12.04 $DISTRO_FILE"
    return_false "is_ubuntu_newer_then 12.10 $DISTRO_FILE"
}

test_is_ubuntu_newer_or_equal_to() {
    return_true "is_ubuntu_newer_or_equal_to 9.04 $DISTRO_FILE"
    return_true "is_ubuntu_newer_or_equal_to 12.04 $DISTRO_FILE"
    return_true "is_ubuntu_newer_or_equal_to 12.10 $DISTRO_FILE"
    return_false "is_ubuntu_newer_or_equal_to 13.10 $DISTRO_FILE"
}

# load shunit2
source /usr/share/shunit2/shunit2
