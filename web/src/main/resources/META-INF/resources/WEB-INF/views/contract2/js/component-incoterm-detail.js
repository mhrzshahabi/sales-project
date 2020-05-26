isc.defineClass("IncotermDetail", isc.Label).addProperties({
    autoFit: false,
    autoDraw: false,
    cursor: "hand",
    align: "center",
    shadowOffset: 5,
    shadowSoftness: 5,
    shadowColor: "black",
    index: -1,
    isValid: null,
    detailRecord: null,
    incotermPartyComponent: null,
    doubleClickHappend: null,
    click: function () {

        this.doubleClickHappend = false;
        let This = this;
        setTimeout(() => {

            if (This.doubleClickHappend)
                return;

            if (this.detailRecord == null || this.incotermPartyComponent == null)
                return;

            if (this.detailRecord.incotermParties == null || this.detailRecord.incotermParties.length === 0 || this.detailRecord.incotermParties.length === 1) {

                let index = (this.index + 1) % this.incotermPartyComponent.dataSource.length;
                let party = this.incotermPartyComponent.getParty(index);
                if (party == null)
                    return;

                this.index = index;
                this.setBackgroundColor(party.bgColor);
                this.detailRecord.incotermParties = [{portion: 100, incotermPartyId: party.id}];

                return;
            }

            this.doubleClick();
        }, 300);
    },
    doubleClick: function () {

        this.doubleClickHappend = true;
        this.setShowShadow(true);
        if (this.detailRecord == null || this.incotermPartyComponent == null)
            return;

        let This = this;
        let currentData = {

            termId: This.detailRecord.termId,
            incotermParties: This.detailRecord.incotermParties
        };
        let callback = function (data) {

            This.setShowShadow(false);
            This.detailRecord.termId = data.termId;
            This.detailRecord.incotermParties = data.incotermParties;
            if (This.detailRecord.incotermParties == null)
                This.detailRecord.incotermParties = [];
            if (This.detailRecord.incotermParties.length === 0) {

                This.index = -1;
                This.setBackgroundColor("lightgray");
            } else if (This.detailRecord.incotermParties.length === 1) {

                let index = -1;
                for (let i = 0; i < This.incotermPartyComponent.dataSource.length; i++)
                    if (This.incotermPartyComponent.dataSource[i].id === This.detailRecord.incotermParties[0].incotermPartyId) {

                        index = i;
                        break;
                    }
                let party = This.incotermPartyComponent.getParty(index);
                if (party == null)
                    return;

                This.index = index;
                This.setBackgroundColor(party.bgColor);
            } else {

                This.index = -1;
                This.setBackgroundColor("springgreen");
            }
        }
        this.incotermPartyComponent.showPartyForm(currentData, callback, () => This.setShowShadow(false));
    },
    initWidget: function () {

        this.Super("initWidget", arguments);
        if (this.detailRecord == null || this.incotermPartyComponent == null)
            return;
        if (this.detailRecord.incotermParties == null)
            this.detailRecord.incotermParties = [];

        if (this.detailRecord.incotermParties.length === 0) {

            this.index = -1;
            this.setBackgroundColor("lightgray");
        } else if (this.detailRecord.incotermParties.length === 1) {

            let index = -1;
            for (let i = 0; i < this.incotermPartyComponent.dataSource.length; i++)
                if (this.incotermPartyComponent.dataSource[i].id === this.detailRecord.incotermParties[0].incotermPartyId) {

                    index = i;
                    break;
                }
            let party = this.incotermPartyComponent.getParty(index);
            if (party == null)
                return;

            this.index = index;
            this.setBackgroundColor(party.bgColor);
        } else {

            this.index = -1;
            this.setBackgroundColor("springgreen");
        }
    },
    getValue: function () {
        return this.detailRecord;
    },
    setValue: function (value) {

        this.detailRecord = value;
    },
    validate: function () {

        this.isValid = this.detailRecord != null && (!this.detailRecord.requiredParty || (this.detailRecord.incotermParties != null && this.detailRecord.incotermParties.length > 0));
        this.setBorder(this.isValid ? "" : "1px solid red");

        return this.isValid;
    }
});
