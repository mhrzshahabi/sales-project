package com.nicico.sales.repository;


import com.nicico.sales.model.entities.base.Groups;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface GroupsDAO extends JpaRepository<Groups, Long>, JpaSpecificationExecutor<Groups> {

}