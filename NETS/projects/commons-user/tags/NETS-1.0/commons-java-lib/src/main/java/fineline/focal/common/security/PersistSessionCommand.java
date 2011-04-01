package fineline.focal.common.security;

import fineline.focal.common.types.v1.UserSession;

import javax.persistence.EntityManager;

public class PersistSessionCommand implements Runnable {
    private UserSession session;
    private EntityManager entityManager;

    public PersistSessionCommand(UserSession session, EntityManager entityManager) {
        this.session = session;
        this.entityManager = entityManager;
    }

    public void run() {
        entityManager.persist(session);
        entityManager.flush();
    }
}
