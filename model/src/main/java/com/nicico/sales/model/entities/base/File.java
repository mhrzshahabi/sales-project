package com.nicico.sales.model.entities.base;

import com.nicico.copper.core.service.minio.EFileAccessLevel;
import com.nicico.sales.model.Auditable;
import com.nicico.sales.model.enumeration.EFileStatus;
import lombok.*;
import lombok.experimental.Accessors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain = true)
@EqualsAndHashCode(of = {"id"}, callSuper = false)
@Entity
@Table(name = "TBL_FILE")
public class File extends Auditable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "SEQ_FILE")
    @SequenceGenerator(name = "SEQ_FILE", sequenceName = "SEQ_FILE", allocationSize = 1)
    @Column(name = "ID")
    private Long id;

    @NotNull
    @Column(name = "C_ENTITY_NAME", nullable = false)
    private String entityName;

    @NotNull
    @Column(name = "N_RECORD_ID", nullable = false)
    private Long recordId;

    @NotNull
    @Column(name = "C_FILE_KEY", nullable = false, unique = true)
    private String fileKey;

    @NotNull
    @Column(name = "E_FILE_STATUS", nullable = false)
    private EFileStatus fileStatus;

    @NotNull
    @Column(name = "E_FILE_ACCESS_LEVEL", nullable = false)
    private EFileAccessLevel accessLevel;

    @Column(name = "C_PERMISSIONS")
    private String permissions;

    @Column(name = "N_OWNER_ID")
    private Long ownerId;
}
