package fineline.focal.common.types.v1;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="user_sessions")
public class UserSession {
    private static final long serialVersionUID = 1L;

    private String id;
    private String username;
    private Date creationDate;

    public UserSession() {}

    public UserSession(String username) {
        this.username = username;
        this.creationDate = new Date();
    }

    @Id
    @GeneratedValue(generator="uuid-sequence")
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    @Column(name="username", nullable=false)
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    @Column(name="creation_date", nullable=false)
    @Temporal(value= TemporalType.TIMESTAMP)
    public Date getCreationDate() {
        return creationDate;
    }
    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }
}
