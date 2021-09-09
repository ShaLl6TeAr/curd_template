package ${packageName};

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.util.ThreadContext;
import org.apache.shiro.web.subject.WebSubject;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import cn.com.ecomonitor.eco.ECO_MonitorApplication;
import ${ApiResult};
import ${PageList};
import ${TestUtil};
import cn.com.ecomonitor.eco.controller.${module}.${ControllerName}Controller;
import cn.com.ecomonitor.eco.controller.${module}.dto.*;
import cn.com.ecomonitor.eco.controller.${module}.vo.*;

import javax.annotation.Resource;
import java.util.Optional;

import static junit.framework.TestCase.assertEquals;

@RunWith(SpringRunner.class)
@ActiveProfiles("${springActive}")
@SpringBootTest(classes={${MainClass}})
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