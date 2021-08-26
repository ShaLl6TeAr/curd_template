package com.hym.devtool.basemodel.pagelist;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.Getter;

import java.util.ArrayList;
import java.util.List;

public class PageList {

    private Integer pageSize = 10;

    private Integer pageNo = 1;

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    @Getter
    public static class PageData<T> {

        private final Integer pageNo;

        private final Integer pageSize;

        private final Integer pages;

        private final long total;

        private final List<T> data;

        public PageData(PageInfo<T> page) {
            this.pageNo = page.getPageNum();
            this.pageSize = page.getSize();
            this.total = page.getTotal();
            this.data = page.getList();
            this.pages = page.getPages();
        }

        public PageData(List<T> rList, int pageNo, int pageSize, long total, int pages) {
            this.pageNo = pageNo;
            this.pageSize = pageSize;
            this.total = total;
            this.data = rList;
            this.pages = pages;
        }

    }

    public static <T> PageData<T> pageList(PageList pageDTO, PageInfoList<T> list) {
        return pageList(pageDTO, list, true);
    }

    public static <T> PageData<T> pageList(PageList pageDTO, PageInfoList<T> list, boolean count) {
        return new PageData<>(pageInfo(pageDTO.getPageNo(), pageDTO.getPageSize(), list, count));
    }

    public static <R, P> PageData<R> pageList(PageList pageDTO, PageInfoList<P> pageList, ChangePageInfoList<R, P> change) {
        return pageList(pageDTO, pageList, change, true);
    }

    public static <R, P> PageData<R> pageList(PageList pageDTO, PageInfoList<P> pageList, ChangePageInfoList<R, P> change, boolean count) {
        PageInfo<P> pageInfo = pageInfo(pageDTO.getPageNo(), pageDTO.getPageSize(), pageList, count);
        return new PageData<>(changeList(pageInfo.getList(), change), pageInfo.getPageNum(), pageInfo.getPageSize(),
                pageInfo.getTotal(), pageInfo.getPages());
    }

    private static <T> PageInfo<T> pageInfo(int pageNo, int pageSize, PageInfoList<T> list, boolean count) {
        PageHelper.startPage(pageNo, pageSize, count);
        return new PageInfo<>(list.list());
    }

    private static <R, P> List<R> changeList(List<P> pList, ChangePageInfoList<R, P> change) {
        List<R> list = new ArrayList<>(pList.size());
        for (P p : pList) {
            list.add(change.change(p));
        }
        return list;
    }

    @FunctionalInterface
    public interface PageInfoList<T> {
        List<T> list();
    }

    @FunctionalInterface
    public interface ChangePageInfoList<R, P> {
        R change(P p);
    }

}
