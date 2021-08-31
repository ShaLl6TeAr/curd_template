<#switch type>
    <#case 'get'>
    public PO get${Name}(String id) {
        return result;
    }
    <#break>
    <#case 'update'>
    public int update${Name}(String id) {
        return 0;
    }
    <#break>
    <#case 'del'>
    public int del${Name}(String id) {
        return 0;
    }<#break>

    </#switch>