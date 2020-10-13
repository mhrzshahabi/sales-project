package com.nicico.sales.utility;

public class StringFormatUtil {

    public static String makeMessageKey(String name, String seperator) {

        return name.
                replaceAll("(^[a-z]|[A-Z0-9])([a-z]+)", seperator + "$1$2").
                toLowerCase().replaceFirst(seperator + "(.*)", "$1");
    }
    public static String makeMessageKeyByRemoveSpace(String name, String seperator) {

        return makeMessageKey(name.replaceAll("(\\s+)(\\S)", "$2".toUpperCase()),seperator);
    }
}
