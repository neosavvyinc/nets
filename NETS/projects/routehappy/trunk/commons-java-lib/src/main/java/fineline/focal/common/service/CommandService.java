/*
 * Copyright (c) 2006 Erik van Oosten.
 *
 * MIT license.
 *
 */
package fineline.focal.common.service;

import java.util.concurrent.Callable;

/**
 * Executes any command within a transaction.
 *
 * @author Erik van Oosten
 * @see http://day-to-day-stuff.blogspot.com/2008/08/java-transaction-boundary-tricks.html
 */
public interface CommandService extends ReadOnlyCommandService {

    /**
     * Execute a command within a transaction.
     *
     * @param command the command to execute (not null)
     */
    void inTransaction(Runnable command);

    /**
     * Execute a command within a transaction.
     *
     * @param <T> result type
     * @param command the command to execute (not null)
     * @return result of command
     * @throws RuntimeException when command throws an exceptie,
     *   message is "CommandService#inTransaction(s)" where s is the toString of command
     */
    <T> T inTransaction(Callable<T> command);
}
