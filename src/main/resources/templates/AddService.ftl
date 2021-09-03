<#switch type>
    <#case 'get'>
    public PO ${name}(String id) {
        return result;
    }
    <#break>
    <#case 'update'>
    public int ${name}(String id) {
        return 0;
    }
    <#break>
    <#case 'del'>
    public int ${name}(String id) {
        return 0;
    }
    <#break>
</#switch>