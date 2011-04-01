package fineline.focal.common.security;

import fineline.focal.common.types.v1.UserSession;

import javax.persistence.EntityManager;

public class RemoveSessionCommand implements Runnable {
    private UserSession session;
    private EntityManager entityManager;

    public RemoveSessionCommand(UserSession session, EntityManager entityManager) {
        this.session = session;
        this.entityManager = entityManager;
    }

    public void run() {
        session = entityManager.find(UserSession.class, session.getId());
        if (session != null) {
            entityManager.remove(session);
        }
    }
}
