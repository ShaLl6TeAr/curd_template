package com.hym.devtool.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Collection;
import java.util.Date;

public class Utils {

    public static final String YEAR_MONTH_DATE_PATTERN = "yyyy-MM-dd";
    public static final String YEAR_MONTH_DATE_HOUR_PATTERN = "yyyy-MM-dd-HH";
    public static final String YEAR_MONTH_DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static final SimpleDateFormat YEAR_MONTH_DATE_SDF = new SimpleDateFormat(YEAR_MONTH_DATE_PATTERN);
    public static final SimpleDateFormat YEAR_MONTH_DATE_HOUR_SDF = new SimpleDateFormat(YEAR_MONTH_DATE_HOUR_PATTERN);
    public static final SimpleDateFormat YEAR_MONTH_DATE_TIME_SDF = new SimpleDateFormat(YEAR_MONTH_DATE_TIME_PATTERN);

    public static final DateTimeFormatter YEAR_MONTH_DATE_DTF = DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_PATTERN);
    public static final DateTimeFormatter YEAR_MONTH_DATE_HOUR_DTF = DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_HOUR_PATTERN);
    public static final DateTimeFormatter YEAR_MONTH_DATE_TIME_DTF = DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_TIME_PATTERN);

    private Utils() {
    }

    public static <T> boolean collectionIsNull(Collection<T> c) {
        return (c == null || c.size() == 0);
    }

    public static <T> boolean collectionIsNotNull(Collection<T> c) {
        return !collectionIsNull(c);
    }

    public static boolean checkIsOtherDevice(int deviceType) {
        return deviceType == 1 || deviceType == 2;
    }

    public static boolean checkIsSelfDevice(int deviceType) {
        return !checkIsOtherDevice(deviceType);
    }

    public static Date str2DateYearMonthDate(String dateStr) throws ParseException {
        return YEAR_MONTH_DATE_SDF.parse(dateStr);
    }

    public static Date str2DateYearMonthDateTime(String dateTimeStr) throws ParseException {
        return YEAR_MONTH_DATE_TIME_SDF.parse(dateTimeStr);
    }

    public static Date str2DateYearMonthDayHourTime(String dateTimeStr) throws ParseException {
        return YEAR_MONTH_DATE_HOUR_SDF.parse(dateTimeStr);
    }

    public static Date LocalDateTime2Date(LocalDateTime ldt) {
        return Date.from(ldt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public static boolean isEqual(String a, String b) {
        if (a == null || b == null) {
            return false;
        }
        return a.equals(b);
    }

    public static boolean isNotEqual(String a, String b) {
        return !isEqual(a, b);
    }

    public static boolean isNull(String s) {
        return s == null || s == "";
    }

    public static boolean isNotNull(String s) {
        return !isNull(s);
    }

    public static char charUppercase(char c) {
        return c >= 'a' && c <= 'z' ? c -= 32 : c;
    }

    public static char charLowercase(char c) {
        return c >= 'A' && c <= 'Z' ? c += 32 : c;
    }
}
