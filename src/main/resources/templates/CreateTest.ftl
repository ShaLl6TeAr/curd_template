package ${testPath}${module};

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import ${ApiResult};
import ${PageList};
import ${TestUtil};
import ${packageName}.${ControllerName}Controller;
import ${packageName}.dto.*;
import ${packageName}.vo.*;
import ${applicationPath}.${MainClass};
<#--<#if model?exists>-->
<#--import ${modelPath}${module}.entity.${Model};-->
<#--</#if>-->

import javax.annotation.Resource;
import java.util.List;
import java.util.ArrayList;
import java.util.Optional;

import static junit.framework.TestCase.assertEquals;

@RunWith(SpringRunner.class)
@ActiveProfiles("${springActive}")
@SpringBootTest(classes={${MainClass}.class})
public class ${Module}Test {

    @Resource
    private TestUtil testUtil;

    @Before
    public void before() {
        testUtil.login();
    }

    @Resource
    private ${Module}Controller ${module}Controller;
}