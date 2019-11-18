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

}
