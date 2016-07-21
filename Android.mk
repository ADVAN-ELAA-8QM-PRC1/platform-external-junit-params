# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

LOCAL_PATH := $(call my-dir)

# build for the host JVM
#-----------------------
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)
LOCAL_MODULE := junit-params-host
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_JAVA_LIBRARIES := \
	junit
include $(BUILD_HOST_JAVA_LIBRARY)

# build for the host dalvik
# -------------------------
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)
LOCAL_MODULE := junit-params-hostdex
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_JAVA_LIBRARIES := \
	junit4-target-hostdex
include $(BUILD_HOST_DALVIK_STATIC_JAVA_LIBRARY)

#-------------------------------
# build a target jar

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-java-files-under, src/main/java)
LOCAL_MODULE := junit-params
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_JAVA_LIBRARIES := \
	junit4-target
include $(BUILD_STATIC_JAVA_LIBRARY)

#-------------------------------
# build a target test jar
#
# Run the test jar as follows:
#   vogar --classpath \
     ${ANDROID_PRODUCT_OUT}/obj/JAVA_LIBRARIES/junit-params-test_intermediates/classes.jack \
     junitparams

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(call all-java-files-under, src/test/java)
LOCAL_JAVA_RESOURCE_DIRS := src/test/resources
LOCAL_MODULE := junit-params-test
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_JAVA_LIBRARIES := \
	junit-params \
	junit-params-assertj-core
include $(BUILD_STATIC_JAVA_LIBRARY)

#-------------------------------
# prebuilt dependencies

include $(CLEAR_VARS)

LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    junit-params-assertj-core:lib/assertj-core-1.7.1.jar

include $(BUILD_MULTI_PREBUILT)
