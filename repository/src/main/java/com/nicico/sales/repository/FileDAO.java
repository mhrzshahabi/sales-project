package com.nicico.sales.repository;

import com.nicico.sales.model.entities.base.File;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FileDAO extends JpaRepository<File, Long> {
	Optional<File> findByFileKey(String fileKey);
}
