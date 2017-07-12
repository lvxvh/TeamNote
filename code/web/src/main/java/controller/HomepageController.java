package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by rudeigerc on 2017/7/12.
 */

@Controller
public class HomepageController {

    @RequestMapping("/homepage")
    public String homepage() {
        return "homepage";
    }
}
