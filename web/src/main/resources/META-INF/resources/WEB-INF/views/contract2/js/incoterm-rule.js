var incotermRuleTab = new nicico.GeneralTabUtil().getDefaultJSPTabVariable();
incotermRuleTab.dynamicForm.fields = BaseFormItems.concat([]);
Object.assign(incotermRuleTab.listGrid.fields, incotermRuleTab.dynamicForm.fields);
nicico.BasicFormUtil.getDefaultBasicForm(incotermRuleTab, "api/incoterm-rule/");
