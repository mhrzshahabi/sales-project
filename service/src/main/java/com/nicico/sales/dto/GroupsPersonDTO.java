package com.nicico.sales.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Accessors(chain = true)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GroupsPersonDTO {
	@NotNull
	@ApiModelProperty(required = true)
	private Long groupsId;
	private Long personId;
	private String desc;


	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("GroupsPersonInfo")
	public static class Info extends GroupsPersonDTO {
		private Long id;
		private Date createdDate;
		private String createdBy;
		private Date lastModifiedDate;
		private String lastModifiedBy;
		private Integer version;
		private GroupsDTO groups;
		private PersonDTO person;

	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("GroupsPersonCreateRq")
	public static class Create extends GroupsPersonDTO {
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("GroupsPersonUpdateRq")
	public static class Update extends GroupsPersonDTO {
		@NotNull
		@ApiModelProperty(required = true)
		private Long id;
		@NotNull
		@ApiModelProperty(required = true)
		private Integer version;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@ApiModel("GroupsPersonDeleteRq")
	public static class Delete {
		@NotNull
		@ApiModelProperty(required = true)
		private List<Long> ids;
	}



	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	@ApiModel("GroupsPersonSpecRs")
	public static class GroupsPersonSpecRs {
		private SpecRs response;
	}

	// ---------------

	@Getter
	@Setter
	@Accessors(chain = true)
	@JsonInclude(JsonInclude.Include.NON_NULL)
	public static class SpecRs {
		private List<GroupsPersonDTO.Info> data;
		private Integer status;
		private Integer startRow;
		private Integer endRow;
		private Integer totalRows;
	}
}
