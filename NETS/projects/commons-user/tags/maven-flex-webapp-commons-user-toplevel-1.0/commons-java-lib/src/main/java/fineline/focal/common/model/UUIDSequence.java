package fineline.focal.common.model;

import java.util.UUID;
import java.util.Vector;

import org.eclipse.persistence.config.SessionCustomizer;
import org.eclipse.persistence.internal.databaseaccess.Accessor;
import org.eclipse.persistence.internal.sessions.AbstractSession;
import org.eclipse.persistence.sequencing.Sequence;
import org.eclipse.persistence.sessions.Session;

/**
 * A UUID sequence generator.  This was copied from http://wiki.eclipse.org/EclipseLink/Examples/JPA/CustomSequencing
 *
 * @author doug
 *
 */
public class UUIDSequence extends Sequence implements SessionCustomizer {
    private static final long serialVersionUID = 1L;

    public UUIDSequence() {
        super();
    }

    public UUIDSequence(String name) {
        super(name);
    }

    @Override
    public Object getGeneratedValue(Accessor accessor, AbstractSession writeSession, String seqName) {
        return UUID.randomUUID().toString().toUpperCase();
    }

    @Override
    public Vector getGeneratedVector(Accessor accessor, AbstractSession writeSession, String seqName, int size) {
        return null;
    }

    @Override
    protected void onConnect() {
    }

    @Override
    protected void onDisconnect() {
    }

    @Override
    public boolean shouldAcquireValueAfterInsert() {
        return false;
    }   

    @Override
    public boolean shouldUseTransaction() {
        return true;
    }

    @Override
    public boolean shouldUsePreallocation() {
        return false;
    }

    public void customize(Session session) throws Exception {
        UUIDSequence sequence = new UUIDSequence("uuid-sequence");
        session.getLogin().addSequence(sequence);
    }
}
