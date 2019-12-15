package com.nicico.sales.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/contact")
public class ContactFormController {

    @RequestMapping("/showForm")
    public String showContact() {
        return "base/contact";
    }

    @RequestMapping("/showFormContractNew")
    public String showTozinTest() {
        return "contract/contractNew";
    }

    @RequestMapping("/contactMolybdenum")
    public String contactNew() {
        return "contract/molybdenum/contactMolybdenumPage1";
    }

    @RequestMapping("/cadMain")
    public String contactCad() {
        return "contract/cad/cadMain";
    }

    @RequestMapping("/cadPageBase")
    public String contactCadPageBase() {
        return "contract/cad/cadPageBase";
    }

    @RequestMapping("/cadPage1")
    public String contactCadPage1() {
        return "contract/cad/cadPage1";
    }

    @RequestMapping("/cadPage2")
    public String contactCadPage2() {
        return "contract/cad/cadPage2";
    }

    @RequestMapping("/concMain")
    public String contactConc() {
        return "contract/conc/concMain";
    }

    @RequestMapping("/concPageBase")
    public String contactConcPageBase() {
        return "contract/conc/concPageBase";
    }

    @RequestMapping("/concPage1")
    public String contactConcPage1() {
        return "contract/conc/concPage1";
    }

    @RequestMapping("/concPage2")
    public String contactConcPage2() {
        return "contract/conc/concPage2";
    }

    @RequestMapping("/contractOther")
    public String contactOther() {
        return "contract/other/contractOther";
    }

}
