#!/bin/bash
"/Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/keytool" -genkey -v -keystore ~/vidyaras-upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias vidyaras-key-alias
