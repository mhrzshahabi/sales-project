//------------------------------------------ TS References -----------------------------------------

///<reference path="CommonUtil.ts"/>
///<reference path="GeneralTabUtil.ts"/>

// @ts-ignore
///<reference path="../../../../../../static/isomorphic/system/development/smartclient.d.ts" />

//------------------------------------------ TS References ---------------------------------------//

//------------------------------------------- Namespaces -------------------------------------------

namespace nicico {

    //------------------------------------------ Classes -------------------------------------------

    export class FilterFormUtil {

        static cancelCallBack: any = function () {

            return;
        };

        static okCallBack: any = function (criteria: isc.Criteria) {

            return criteria;
        };

        static createFilterBuilder(creator: JSPTabVariable, criteria: isc.AdvancedCriteria): void {
            // @ts-ignore
            creator.filterBuilder.main = isc.FilterBuilder.create({
                // @ts-ignore
                dataSource: creator.restDataSource.main,
                criteria: criteria ? criteria : {
                    // @ts-ignore
                    _constructor: "AdvancedCriteria",
                    operator: "and", criteria: []
                },
                fieldPickerWidth: "200",
                valueItemWidth: "200",
                width: "95%",
                height: "100%",
                margin: 5,
                getFieldOperators: function (fieldName) {

                    let dataSource = this.dataSource;
                    if (dataSource == null)
                        return this.Super("getFieldOperators", arguments);

                    let field = dataSource.getField(fieldName);
                    if (field == null)
                        return this.Super("getFieldOperators", arguments);

                    if (field.filterOperator)
                        return field.filterOperator;

                    // @ts-ignore
                    if (field.type === "date") return ["greaterThan", "lessThan", "greaterOrEqual", "lessOrEqual", "isNull", "notNull"];
                    // @ts-ignore
                    if (field.type === "boolean") return ["isNull", "notNull", "equals", "notEqual", "iEquals", "iNotEqual", "equalsField", "notEqualField", "iEqualsField", "iNotEqualField"];
                    // @ts-ignore
                    if (field.type === "integer" || field.type === "float") return ["equals", "notEqual", "iEquals", "iNotEqual", "greaterThan", "lessThan", "greaterOrEqual", "lessOrEqual",
                        "iEqualsField", "iNotEqualField", "isBlank", "notBlank", "isNull", "notNull", "inSet", "notInSet", "equalsField",
                        "notEqualField", "greaterThanField", "lessThanField", "greaterOrEqualField", "lessOrEqualField"];

                    return this.Super("getFieldOperators", arguments);
                },
                getValueFieldProperties: function (type, fieldName, operatorId, itemType) {

                    let superProperties = this.Super("getValueFieldProperties", arguments);
                    if (!superProperties) superProperties = {};

                    const field = this.dataSource.getField(fieldName);

                    if (field != null && field.type.toLowerCase() === "date")
                    // @ts-ignore
                        return Object.assign(superProperties, {
                            // @ts-ignore
                            editorType: "DateItem",
                            useTextField: true,
                            type: "date",
                            dateFormatter: "toJapanShortDate"
                        });

                    return superProperties;
                }

            });
            // @ts-ignore
            creator.filterBuilder.main.topOperatorForm.setHeight("95%");
        }

        static createButtonLayout(creator: JSPTabVariable): void {

            let This = this;
            // @ts-ignore
            let cancel = isc.IButtonCancel.create({

                // @ts-ignore
                click: function () {

                    // @ts-ignore
                    creator.window.main.close();
                    // @ts-ignore
                    if (creator.variable.owner != null)
                    // @ts-ignore
                        creator.variable.owner.show();

                    This.cancelCallBack();
                },
            });
            // @ts-ignore
            let ok = isc.IButtonSave.create({

                // @ts-ignore
                click: function () {

                    // @ts-ignore
                    creator.window.main.close();
                    // @ts-ignore
                    if (creator.variable.owner != null)
                    // @ts-ignore
                        creator.variable.owner.show();

                    // @ts-ignore
                    This.okCallBack(creator.filterBuilder.main.getCriteria());
                },
            });

            // @ts-ignore
            creator.hLayout.main = isc.HLayout.create({

                width: "100%",
                padding: 10,
                layoutMargin: 10,
                membersMargin: 10,
                edgeImage: "",
                showEdges: false,
                members: [ok, cancel]
            });
        }

        static createWindow(creator: JSPTabVariable, title: string): void {

            // @ts-ignore
            let width = creator.variable.width ? creator.variable.width : "40%";
            // @ts-ignore
            let height = creator.variable.height ? creator.variable.height : "400";
            // @ts-ignore
            creator.window.main = isc.Window.nicico.getDefault(title, [
                // @ts-ignore
                creator.filterBuilder.main, creator.hLayout.main
            ], width, height);
        }

        static show(owner: isc.Window, title: string, restDataSource: isc.RestDataSource, criteria: isc.AdvancedCriteria, width: string = null, height: string = null) {

            let creator = new GeneralTabUtil().getDefaultJSPTabVariable();
            // @ts-ignore
            creator.restDataSource.main = restDataSource;
            // @ts-ignore
            creator.variable.width = width;
            // @ts-ignore
            creator.variable.height = height;
            // @ts-ignore
            creator.variable.owner = owner;
            if (owner != null)
                owner.close();

            this.createFilterBuilder(creator, criteria);
            this.createButtonLayout(creator);
            this.createWindow(creator, title);

            // @ts-ignore
            creator.window.main.show();

            // @ts-ignore
            return creator.window.main;
        }
    }

    //------------------------------------------ Classes -----------------------------------------//
}

//------------------------------------------- Namespaces -----------------------------------------//
