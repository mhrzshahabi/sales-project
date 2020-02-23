package com.nicico.sales.model.entities.base;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.Subselect;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Immutable
@Subselect(
        "SELECT" +
                " bankgroupdesc," +
                "buyerid," +
                "codeetebarenosacustomer," +
                "codemarkazhazinehcustomer," +
                "codemarkazhazinehlc," +
                "codemarkazhazinehmahsol," +
                "codenosaalayandegi," +
                "codenosabank," +
                "codenosacustomer," +
                "codenosamahsol," +
                "codenosamalyate," +
                "customerid," +
                "vi.cust_name," +
                "gdsname," +
                "ghematunit," +
                "goodsid," +
                "grupgoodname," +
                "grupgoodsnosa," +
                "hav_finaldate," +
                "havalehid," +
                "havealayandegi," +
                "havemaleyate," +
                "inv_date," +
                "vi.inv_id," +
                "inv_other_kosorat," +
                "inv_sented," +
                "lc_datesarresed," +
                "LCID," +
                "mablaghkol," +
                "markazhazinehalayandegi," +
                "markazhazinehmalyate," +
                "payforavarezalayandegh," +
                "payforavarezmaleyate," +
                "shomarehsorathesab," +
                "totalkosorat," +
                "typefrosh," +
                "weightreal," +
                "cust_codenosa" +
                " FROM" +
                " n_master.view_innersalesforsalse vi" +
                " INNER JOIN n_master.customer1tbl mc ON mc.cust_id = vi.customerid" +
                " WHERE vi.inv_id NOT IN (select ti.INV_ID from TBL_INVOICEINTERNALDOCUMENT ti)"
)
public class InvoiceInternal {
    @Id
    @Column(name = "INV_ID", length = 100)
    private String id;

    @Column(name = "LCID", length = 100)
    private String lcId;

    @Column(name = "HAVALEHID", length = 100)
    private String havalehId;

    @Column(name = "INV_DATE", length = 30)
    private String invDate;

    @Column(name = "BUYERID", length = 100)
    private String buyerId;

    @Column(name = "CUSTOMERID", length = 100)
    private String customerId;

    @Column(name = "GOODSID", precision = 10)
    private Long goodId;

    @Column(name = "INV_OTHER_KOSORAT", precision = 10)
    private Double invOtherKosorat;

    @Column(name = "HAV_FINALDATE", length = 30)
    private String havFinalDate;

    @Column(name = "WEIGHTREAL", precision = 10)
    private Double weightReal;

    @Column(name = "GHEMATUNIT", precision = 10)
    private Double ghematUnit;

    @Column(name = "TOTALKOSORAT", precision = 10)
    private Double totalKosorat;

    @Column(name = "MABLAGHKOL", precision = 10)
    private Double mablaghKol;

    @Column(name = "SHOMAREHSORATHESAB")
    private String shomarehSoratHesab;

    @Column(name = "PAYFORAVAREZMALEYATE", precision = 10)
    private Double payForAvarezMalyat;

    @Column(name = "PAYFORAVAREZALAYANDEGH", precision = 10)
    private Double payForAvarezAlayandegi;

    @Column(name = "INV_SENTED", length = 30)
    private String invSented;

    @Column(name = "TYPEFROSH", precision = 10)
    private Long typeForosh;

    @Column(name = "HAVEALAYANDEGI", precision = 10)
    private Long haveAlayandegi;

    @Column(name = "CODENOSAALAYANDEGI", length = 100)
    private String codeNosaAlayandegi;

    @Column(name = "MARKAZHAZINEHALAYANDEGI", length = 100)
    private String markazHazineAlayandegi;

    @Column(name = "HAVEMALEYATE", precision = 10)
    private Long haveMalyat;

    @Column(name = "CODENOSAMALYATE", length = 100)
    private String codeNosaMalyat;

    @Column(name = "MARKAZHAZINEHMALYATE", length = 100)
    private String markazHazineMalyat;

    @Column(name = "CODENOSABANK", length = 100)
    private String codeNosaBank;

    @Column(name = "CODENOSACUSTOMER", length = 100)
    private String codeNosaCustomer;

    @Column(name = "CODEETEBARENOSACUSTOMER", length = 100)
    private String codeEtebarNosaCustomer;

    @Column(name = "CODEMARKAZHAZINEHCUSTOMER", length = 100)
    private String codeMarkazHazineCustomer;

    @Column(name = "CODEMARKAZHAZINEHLC", length = 100)
    private String codeMarkazHazineHlc;

    @Column(name = "CODENOSAMAHSOL", length = 100)
    private String codeNosaMahsol;

    @Column(name = "CODEMARKAZHAZINEHMAHSOL", length = 100)
    private String codeMarkazHazineMahsol;

    @Column(name = "BANKGROUPDESC", length = 500)
    private String bankGroupDesc;

    @Column(name = "CUST_NAME", length = 500)
    private String customerName;

    @Column(name = "GDSNAME", length = 1000)
    private String gdsName;

    @Column(name = "GRUPGOODSNOSA", length = 100)
    private String groupGoodsNosa;

    @Column(name = "GRUPGOODNAME", length = 1000)
    private String groupGoodName;

    @Column(name = "LC_DATESARRESED", length = 100)
    private String lcDateSarReceid;

    @Column(name = "CUST_CODENOSA", length = 100)
    private String codeTafsiliNosa;


}
