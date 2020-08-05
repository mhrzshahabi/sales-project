package com.nicico.sales.model.entities.base;

import com.nicico.sales.model.entities.common.BaseEntity;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_PERSON")
public class Person extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_PERSON")
    @SequenceGenerator(name = "SEQ_PERSON", sequenceName = "SEQ_PERSON", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @Setter(AccessLevel.NONE)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONTACT_ID", insertable = false, updatable = false, foreignKey = @ForeignKey(name = "person2contact"))
    private Contact contact;

    @Column(name = "CONTACT_ID")
    private Long contactId;

    @Column(name = "FULL_NAME", nullable = false)
    private String fullName;

    @Column(name = "JOB_TITLE")
    private String jobTitle;

    @Column(name = "TITLE", length = 20)
    private String title;

    @Column(name = "EMAIL", length = 200)
    private String email;

    @Column(name = "EMAIL1")
    private String email1;

    @Column(name = "EMAIL2")
    private String email2;

    @Column(name = "WEB_ADDRESS")
    private String webAddress;

    @Column(name = "PHONE_NO")
    private String phoneNo;

    @Column(name = "FAX_NO")
    private String faxNo;

    @Column(name = "MOBILE_NO", length = 20)
    private String mobileNo;

    @Column(name = "MOBILE_NO1", length = 20)
    private String mobileNo1;

    @Column(name = "MOBILE_NO2", length = 20)
    private String mobileNo2;

    @Column(name = "WHATSAPP")
    private String whatsApp;

    @Column(name = "WECHAT")
    private String weChat;

    @Column(name = "ADDRESS", length = 1000)
    private String address;

}