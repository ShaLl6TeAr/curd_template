package com.hym.devtool.statistic;

import lombok.Data;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Data
public class BaseStatDTO {

    private String startDate;

    private String endDate;

    private Integer valueType;

    private String date;

    private StatDate statDate;

    public BaseStatDTO() {
    }

    private static final String YEAR_MONTH_DATE_PATTERN = "yyyy-MM-dd";
    private static final String YEAR_MONTH_DATE_HOUR_PATTERN = "yyyy-MM-dd HH:00:00";
    private static final String YEAR_MONTH_DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static final int VALUE_TYPE_AROUND12HOUR = 1;
    public static final int VALUE_TYPE_TODAY_TYPE = 2;
    public static final int VALUE_TYPE_DATE_HOUR_TYPE = 3;
    public static final int VALUE_TYPE_DATE_TYPE = 4;

    private static final int PATTERN_TYPE_TIME = 1;
    private static final int PATTERN_TYPE_MINUTE = 2;
    private static final int PATTERN_TYPE_HOUR = 3;
    private static final int PATTERN_TYPE_DATE = 4;
    private static final int PATTERN_TYPE_WEEK = 5;
    private static final int PATTERN_TYPE_MONTH = 6;
    private static final int PATTERN_TYPE_YEAR = 7;

    public static final HashMap<Integer, Integer> VALUE_DATE_TYPE = new HashMap<>();
    public static final HashMap<Integer, String> SQL_DATE_PATTERN = new HashMap<>();
    public static final HashMap<Integer, String> DAY_OF_WEEK = new HashMap<>();
    public static final HashMap<Integer, String> DATE_PATTERN = new HashMap<>();

    static {
        VALUE_DATE_TYPE.put(VALUE_TYPE_AROUND12HOUR, PATTERN_TYPE_HOUR);
        VALUE_DATE_TYPE.put(VALUE_TYPE_TODAY_TYPE, PATTERN_TYPE_HOUR);
        VALUE_DATE_TYPE.put(VALUE_TYPE_DATE_HOUR_TYPE, PATTERN_TYPE_HOUR);
        VALUE_DATE_TYPE.put(VALUE_TYPE_DATE_TYPE, PATTERN_TYPE_DATE);

        SQL_DATE_PATTERN.put(PATTERN_TYPE_TIME, "%Y-%m-%d %H:%i:%s");
        SQL_DATE_PATTERN.put(PATTERN_TYPE_MINUTE, "%Y-%m-%d %H:%i:00");
        SQL_DATE_PATTERN.put(PATTERN_TYPE_HOUR, "%Y-%m-%d %H:00:00");
        SQL_DATE_PATTERN.put(PATTERN_TYPE_DATE, "%Y-%m-%d");
        SQL_DATE_PATTERN.put(PATTERN_TYPE_WEEK, "%w");
        SQL_DATE_PATTERN.put(PATTERN_TYPE_MONTH, "%Y-%m");
        SQL_DATE_PATTERN.put(PATTERN_TYPE_YEAR, "%Y");

        DATE_PATTERN.put(PATTERN_TYPE_TIME, "yyyy-MM-dd HH:mm:ss");
        DATE_PATTERN.put(PATTERN_TYPE_MINUTE, "yyyy-MM-dd HH:mm:00");
        DATE_PATTERN.put(PATTERN_TYPE_HOUR, "yyyy-MM-dd HH:00:00");
        DATE_PATTERN.put(PATTERN_TYPE_DATE, "yyyy-MM-dd");
        DATE_PATTERN.put(PATTERN_TYPE_WEEK, "WW");
        DATE_PATTERN.put(PATTERN_TYPE_MONTH, "yyyy-MM");
        DATE_PATTERN.put(PATTERN_TYPE_YEAR, "yyyy");

        DAY_OF_WEEK.put(0, "星期日");
        DAY_OF_WEEK.put(1, "星期一");
        DAY_OF_WEEK.put(2, "星期二");
        DAY_OF_WEEK.put(3, "星期三");
        DAY_OF_WEEK.put(4, "星期四");
        DAY_OF_WEEK.put(5, "星期五");
        DAY_OF_WEEK.put(6, "星期六");
        DAY_OF_WEEK.put(7, "星期日");
    }

    private void initDate() throws RuntimeException {
        switch (this.valueType) {
            case VALUE_TYPE_AROUND12HOUR:
                LocalDateTime time = LocalDateTime.parse(this.date, DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_TIME_PATTERN));
                this.startDate = time.minusHours(6).format(DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_HOUR_PATTERN));
                this.endDate = time.plusHours(5).format(DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_HOUR_PATTERN));
                break;
            case VALUE_TYPE_TODAY_TYPE:
                LocalDateTime now = LocalDateTime.now();
                this.startDate = now.withHour(0).format(DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_HOUR_PATTERN));
                this.endDate = now.withHour(0).plusDays(1).format(DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_HOUR_PATTERN));
                break;
            case PATTERN_TYPE_HOUR:
            case PATTERN_TYPE_DATE:
                break;
            default:
                throw new RuntimeException("value type err");
        }
    }

    public Map<String, String> getRawValueMap() throws RuntimeException {
        if (this.statDate == null) {
            this.statDate = new StatDate(this.valueType, this.startDate, this.endDate);
        }
        int dateType;
        switch (this.valueType) {
            case VALUE_TYPE_AROUND12HOUR:
            case VALUE_TYPE_TODAY_TYPE:
            case PATTERN_TYPE_HOUR:
                dateType = PATTERN_TYPE_HOUR;
                break;
            case PATTERN_TYPE_DATE:
                dateType = PATTERN_TYPE_DATE;
                break;
            default:
                throw new RuntimeException("value type err");
        }
        return this.statDate.getDateValueMap(dateType);
    }

    public StatDate getStatDate() throws RuntimeException {
        if (this.statDate == null) {
            this.initDate();
            this.statDate = new StatDate(VALUE_DATE_TYPE.get(this.valueType), this.startDate, this.endDate);
        }
        return statDate;
    }

    @Data
    public static class StatDate {
    
        private Integer dateType;
    
        private LocalDateTime startDate;
    
        private LocalDateTime endDate;

        public StatDate(Integer dateType, String startDate, String endDate) {
            this.dateType = dateType;
            this.startDate = LocalDateTime.parse(startDate, DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_TIME_PATTERN));
            this.endDate = LocalDateTime.parse(endDate, DateTimeFormatter.ofPattern(YEAR_MONTH_DATE_TIME_PATTERN));
        }

        public String getSqlDatePattern() {
            return BaseStatDTO.SQL_DATE_PATTERN.get(dateType);
        }

        public String getDatePattern() {
            return BaseStatDTO.DATE_PATTERN.get(dateType);
        }

        public Map<String, String> getDateValueMap(int dateType) throws RuntimeException {
            LocalDateTime startTime = this.startDate;
            LocalDateTime endTime = this.endDate;

            ChronoUnit chronoUnit;
            switch (dateType) {
                case PATTERN_TYPE_HOUR:
                    chronoUnit = ChronoUnit.HOURS;
                    break;
                case PATTERN_TYPE_DATE:
                    chronoUnit = ChronoUnit.DAYS;
                    break;
                case PATTERN_TYPE_WEEK:
                    chronoUnit = ChronoUnit.WEEKS;
                    break;
                case PATTERN_TYPE_MONTH:
                    chronoUnit = ChronoUnit.MONTHS;
                    break;
                case PATTERN_TYPE_YEAR:
                    chronoUnit = ChronoUnit.YEARS;
                    break;
                default:
                    throw new RuntimeException("value type err");
            }

            long count = chronoUnit.between(startTime, endTime);
            Map<String, String> dateValueMap = new LinkedHashMap<>();

            for (int i = 0; i < count; i++) {
                LocalDateTime t;
                switch (dateType) {
                    case PATTERN_TYPE_HOUR:
                        t = startTime.plusHours(i);
                        break;
                    case PATTERN_TYPE_DATE:
                        t = startTime.plusDays(i);
                        break;
                    case PATTERN_TYPE_WEEK:
                        t = startTime.plusWeeks(i);
                        break;
                    case PATTERN_TYPE_MONTH:
                        t = startTime.plusMonths(i);
                        break;
                    case PATTERN_TYPE_YEAR:
                        t = startTime.plusYears(i);
                        break;
                    default:
                        throw new RuntimeException("value type err");
                }

                String dateStr = t.format(DateTimeFormatter.ofPattern(DATE_PATTERN.get(dateType)));
                if (dateType == PATTERN_TYPE_WEEK && DAY_OF_WEEK.containsKey(Integer.valueOf(dateStr))) {
                    dateValueMap.put(DAY_OF_WEEK.get(Integer.valueOf(dateStr)), "0");
                } else {
                    dateValueMap.put(dateStr, "0");
                }
            }
            return dateValueMap;
        }
    }
}

