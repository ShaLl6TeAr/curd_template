package com.hym.devtool.base;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class SqlBuilder {

    public static class Condition {
        private String condition;
        private String field;
        private Object value;
        private Object valueBegin;
        private Object valueEnd;
        private List<Condition> orList;

        public Condition(String condition, String field, Object value) {
            this.field = "`" + field + "`";
            this.value = value;
            this.condition = condition;
        }

        public Condition(String condition, String field, Object valueBegin, Object valueEnd) {
            this.field = field;
            this.valueBegin = valueBegin;
            this.valueEnd = valueEnd;
            this.condition = condition;
        }

        public String getCondition() {
            return condition;
        }
        public String getField() {
            return field;
        }
        public Object getValue() {
            return value;
        }
        public Object getValueBegin() {
            return valueBegin;
        }
        public Object getValueEnd() {
            return valueEnd;
        }
        public List<Condition> getOrList() {
            return orList;
        }
    }

    public static class Limit {
        private final long offset;
        private final int limit;

        public Limit(long offset, int limit) {
            this.offset = offset;
            this.limit = limit;
        }

        public long getOffset() {
            return offset;
        }
        public int getLimit() {
            return limit;
        }
    }

    public static class Operation {
        private String table;
        private String fields;
        private List<Condition> conditions;
        private String order;
        private String group;
        private Limit limit;

        public Operation fields(String ...fields) {
            this.fields = buildField(fields);
            return this;
        }

        public Operation allFields() {
            return this;
        }

        public Operation from(String table) {
            this.table = table;
            return this;
        }

        public Operation equalValue(String field, Object value) {
            return condition(field, "=", value);
        }

        public Operation grateThan(String field, Object value) {
            return condition(field, ">", value);
        }

        public Operation grateEqualThan(String field, Object value) {
            return condition(field, ">=", value);
        }

        public Operation smallThan(String field, Object value) {
            return condition(field, "<", value);
        }

        public Operation smallEqualThan(String field, Object value) {
            return condition(field, "<=", value);
        }

        public Operation or(List<Condition> conditions) {
            Condition or = new Condition("or", null, null);
            or.orList = conditions;
            this.conditions.add(or);
            return this;
        }

        public Operation condition(String field, String condition, Object value) {
            if (this.conditions == null) {
                this.conditions = new ArrayList<>();
            }
            this.conditions.add(new Condition(condition, field, value));
            return this;
        }

        public Operation between(String field, Object valueBegin, Object valueEnd) {
            if (this.conditions == null) {
                this.conditions = new ArrayList<>();
            }
            this.conditions.add(new Condition("between", field, valueBegin, valueEnd));
            return this;
        }

        public Operation or(Condition ...condition) {
            return this;
        }

        public Operation orderBy(String ...fields) {
            this.order = buildField(fields);
            return this;
        }

        public Operation groupBy(String ...fields) {
            this.group = buildField(fields);
            return this;
        }

        public Operation limit(long offset, int limit) {
            this.limit = new Limit(offset, limit);
            return this;
        }

        public String buildField(String ...field) {
            return Arrays.stream(field).map(d -> "`" + d + "`").collect(Collectors.joining(","));
        }

        public List<String> buildValue(String ...value) {
            return Arrays.stream(value).map(d -> "'" + d + "'").collect(Collectors.toList());
        }

        public String getTable() {
            return table;
        }

        public String getFields() {
            return fields;
        }

        public List<Condition> getConditions() {
            return conditions;
        }

        public String getOrder() {
            return order;
        }

        public String getGroup() {
            return group;
        }

        public Limit getLimit() {
            return limit;
        }
    }

    public static Operation select() {
        Operation operation = new Operation();
        return operation;
    }



}
