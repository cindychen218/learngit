package com.yinhai.ykt.px.controller;

import com.yinhai.core.app.ta3.web.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController extends BaseController {
   @RequestMapping("/testController.do")
    public String execute(){
       System.out.println("2323");
        return "px/addOrg";
    }
}
