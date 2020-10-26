package com.nicico.sales.utility;

public class StringFormatUtil {

    public static String makeMessageKey(String name, String separator) {

        return name.
                replaceAll("(^[a-z]|[A-Z0-9])([a-z]+)", separator + "$1$2").
                toLowerCase().replaceFirst("^(" + separator + "*)(.*)", "$2");
    }

    public static String makeMessageKeyByRemoveSpace(String name, String separator) {

        return name.replaceAll("(\\s+)(\\S)", separator + "$2").
                replaceFirst("^(" + separator + "*)(.*)", "$2").
                trim();
    }
}
