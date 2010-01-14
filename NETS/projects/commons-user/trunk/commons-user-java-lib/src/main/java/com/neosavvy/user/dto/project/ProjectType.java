package com.neosavvy.user.dto.project;

import javax.persistence.*;
/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * User: adamparrish
 * Date: Jan 2, 2010
 * Time: 11:39:24 AM
 */
@Entity
@Table(
    name="PROJECT_TYPE" ,
    uniqueConstraints = {
            @UniqueConstraint(columnNames = {"ID"})
    }
)
public class ProjectType {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "project_type_id_seq")
    @SequenceGenerator(name = "project_type_id_seq", sequenceName = "project_type_id_seq", allocationSize=1)
	@Column(name="ID")
	private Long id;

    @Column(name="TYPE")
    private String type;
    
}
