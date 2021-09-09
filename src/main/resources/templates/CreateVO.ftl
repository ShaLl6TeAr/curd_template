package ${packageName}.vo;

public class ${Name}VO {

<#switch type>
    <#case 'add'>
    private Integer addCount;

    private String id;

    public ${Name}VO(Integer count, String id) {
        this.addCount = count;
        this.id = id;
    }

    public Integer getAddCount() {
        return this.addCount;
    }

    public String getId() {
        return this.id;
    }
    <#break>
    <#case 'update'>
    private Integer updateCount;

    private String id;

    public ${Name}VO(Integer count, String id) {
        this.updateCount = count;
        this.id = id;
    }

    public Integer getUpdateCount() {
        return this.updateCount;
    }

    public String getId() {
    return this.id;
    }
    <#break>
    <#case 'del'>
    private Integer delCount;

    private String id;

    public ${Name}VO(Integer count, String id) {
        this.delCount = count;
        this.id = id;
    }

    public Integer getDelCount() {
        return this.delCount;
    }

    public String getId() {
    return this.id;
    }
    <#break>
</#switch>

}
