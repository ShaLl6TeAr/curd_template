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
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringRunner.class)
<#--@ActiveProfiles("${springPropertiesActive}")-->
<#--@SpringBootTest(classes={${MainClass}})-->
public class ${Module}Test {

    @Resource
    private SecurityManager securityManager;

    @Resource
    private WebApplicationContext webApplicationContext;

    //用户登录
    private void login() {
        MockHttpServletRequest mReq = new MockHttpServletRequest(webApplicationContext.getServletContext());
        MockHttpServletResponse mRsp = new MockHttpServletResponse();
        MockHttpSession mockHttpSession = new MockHttpSession(webApplicationContext.getServletContext());
        mReq.setSession(mockHttpSession);
        SecurityUtils.setSecurityManager(securityManager);
        Subject subject = new WebSubject.Builder(mReq, mRsp).buildWebSubject();
        UsernamePasswordToken token = new UsernamePasswordToken("admin", "Huihang@1234", true);
        subject.login(token);
        ThreadContext.bind(subject);
    }

    @Before
    public void before() {
        login();
    }

    @Resource
    private ${Module}Controller ${module}Controller;

    @Test
    public void test${Module}() {

    }
}