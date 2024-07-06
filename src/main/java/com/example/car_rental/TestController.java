package com.example.car_rental;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
    @RequestMapping("test")//页面输入test便会到这里来，例如 http://localhost:8080/test
    public String test(){
        //对应的jsp页面，在jsp下对的路径以及页面名称
        return "hello";
    }
}
