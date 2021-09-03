package ${packageName}.vo;

public class ${Name}VO {

<#switch type>
    <#case 'add'>
    private Integer addCount;

    private String id;

    public ${Name}VO(Integer addCount, String id) {
        this.addCount = addCount;
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

    public ${Name}VO(Integer updateCount) {
        this.updateCount = updateCount;
    }

    public Integer getUpdateCount() {
        return this.updateCount;
    }
    <#break>
    <#case 'del'>
    private Integer delCount;

    public ${Name}VO(Integer delCount) {
        this.delCount = delCount;
    }

    public Integer getDelCount() {
        return this.delCount;
    }
    <#break>
</#switch>

}
