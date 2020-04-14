package com.nicico.sales.utility;

public class MessageKeyUtil {

    public static String makeMessageKey(String name) {

        return name.
                replaceAll("(^[a-z]|[A-Z0-9])([a-z]*)", "-$1$2").
                toLowerCase().replaceFirst("-(.*)", "$1");
    }
}
