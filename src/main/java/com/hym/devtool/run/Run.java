package com.hym.devtool.run;

import com.hym.devtool.generator.RpcGen;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

@Component
public class Run implements ApplicationRunner {

    private static final String METHOD = "method";
    private static final String GEN_RPC = "genRpc";



    @Override
    public void run(ApplicationArguments args) throws Exception {

        String method = System.getProperty(METHOD);

        switch (method) {
            case GEN_RPC:
                RpcGen.genRpc();
                break;
            default:
                System.out.println("can not find any method: " + method);
        }

    }
}
