package ${packageName}.vo;

public class ${Name}VO {

    <#switch type>
    <#case 'update'>
    private Integer updateCount;

    public void setUpdateCount(Integer updateCount) {
    this.updateCount = updateCount;
    }

    public Integer getUpdateCount() {
    return this.updateCount;
    }
    <#break>
    <#case 'del'>
        private Integer delCount;

        public void setDelCount(Integer delCount) {
        this.delCount = delCount;
        }

        public Integer getDelCount() {
        return this.delCount;
        }
        <#break>
    </#switch>

}
