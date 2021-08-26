package com.hym.devtool.basemodel;

public class ApiResult<T> {

//    @ApiModelProperty(value = "响应码")
    private Integer code = 1;

//    @ApiModelProperty(value = "响应信息")
    private String message = "操作成功";

//    @ApiModelProperty(value = "数据")
    private T result;

    public ApiResult() {
    }

    public ApiResult(T data) {
        this.result = data;
    }

    public ApiResult(T data, String message) {
        this.message = message;
        this.result = data;
    }

    public ApiResult(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public ApiResult(T data, Integer code, String message) {
        this.result = data;
        this.code = code;
        this.message = message;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }
}