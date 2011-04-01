/*
 * Copyright (c) 2006 Erik van Oosten.
 *
 * MIT license.
 *
 */
package fineline.focal.common.service;

import java.util.concurrent.Callable;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Erik van Oosten
 * @see http://day-to-day-stuff.blogspot.com/2008/08/java-transaction-boundary-tricks.html
 */
@Transactional
public class DefaultCommandService implements CommandService {

    /** {@inheritDoc} */
    @Transactional(readOnly = true)
    public void inReadOnlyTransaction(Runnable command) {
        command.run();
    }

    /** {@inheritDoc} */
    @Transactional(readOnly = true)
    public <T> T inReadOnlyTransaction(Callable<T> command) {
        return doCall(command);
    }

    /** {@inheritDoc} */
    @Transactional
    public void inTransaction(Runnable command) {
        command.run();
    }

    /** {@inheritDoc} */
    @Transactional
    public <T> T inTransaction(Callable<T> command) {
        return doCall(command);
    }

    private <T> T doCall(Callable<T> command) {
        try {
            return command.call();
        } catch (Exception e) {
            throw new RuntimeException("CommandService#inTransaction(" + command.toString() + ")", e);
        }
    }
}
