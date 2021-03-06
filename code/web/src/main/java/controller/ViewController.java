package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by qjr on 2017/7/13.
 */
@Controller
public class ViewController {

    @RequestMapping(path = {"/index", "/"})
    public String index() {
        return "index";
    }

    @RequestMapping("/homepage")
    public String homepage(@RequestParam("userId") int userId, HttpServletRequest request) {
        request.setAttribute("userId", userId);
        return "homepage";
    }

    @RequestMapping("/explore")
    public String explore() {
        return "explore";
    }

    @RequestMapping("/admin")
    public String admin() {
        return "admin";
    }
}
