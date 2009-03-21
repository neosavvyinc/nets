package com.neosavvy.svn.analytics;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.Set;

import org.junit.Ignore;
import org.junit.Test;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.neosavvy.svn.analytics.util.SvnKitUtil;

public class TestServerConnection {

    @Test
    @Ignore
    public void testServerConnection() {
        /*
         * Default values:
         */
        String url = "https://svn.roundarch.com/repos/USA";
        String name = "aparrish";
        String password = "subw@y1";
        long startRevision = 0;
        long endRevision = -1;// HEAD (the latest) revision
        /*
         * Initializes the library (it must be done before ever using the
         * library itself)
         */
        SvnKitUtil.setupLibrary();

        SVNRepository repository = null;

        try {
            /*
             * Creates an instance of SVNRepository to work with the repository.
             * All user's requests to the repository are relative to the
             * repository location used to create this SVNRepository. SVNURL is
             * a wrapper for URL strings that refer to repository locations.
             */
            repository = SVNRepositoryFactory.create(SVNURL
                    .parseURIEncoded(url));
        } catch (SVNException svne) {
            /*
             * Perhaps a malformed URL is the cause of this exception.
             */
            System.err
                    .println("error while creating an SVNRepository for the location '"
                            + url + "': " + svne.getMessage());
            System.exit(1);
        }

        /*
         * User's authentication information (name/password) is provided via an
         * ISVNAuthenticationManager instance. SVNWCUtil creates a default
         * authentication manager given user's name and password.
         * 
         * Default authentication manager first attempts to use provided user
         * name and password and then falls back to the credentials stored in
         * the default Subversion credentials storage that is located in
         * Subversion configuration area. If you'd like to use provided user
         * name and password only you may use BasicAuthenticationManager class
         * instead of default authentication manager:
         * 
         * authManager = new BasicAuthenticationsManager(userName,
         * userPassword);
         * 
         * You may also skip this point - anonymous access will be used.
         */
        ISVNAuthenticationManager authManager = SVNWCUtil
                .createDefaultAuthenticationManager(name, password);
        repository.setAuthenticationManager(authManager);

        /*
         * Gets the latest revision number of the repository
         */
        try {
            endRevision = repository.getLatestRevision();
        } catch (SVNException svne) {
            System.err
                    .println("error while fetching the latest repository revision: "
                            + svne.getMessage());
            System.exit(1);
        }

        Collection logEntries = null;
        try {
            /*
             * Collects SVNLogEntry objects for all revisions in the range
             * defined by its start and end points [startRevision, endRevision].
             * For each revision commit information is represented by
             * SVNLogEntry.
             * 
             * the 1st parameter (targetPaths - an array of path strings) is set
             * when restricting the [startRevision, endRevision] range to only
             * those revisions when the paths in targetPaths were changed.
             * 
             * the 2nd parameter if non-null - is a user's Collection that will
             * be filled up with found SVNLogEntry objects; it's just another
             * way to reach the scope.
             * 
             * startRevision, endRevision - to define a range of revisions you
             * are interested in; by default in this program - startRevision=0,
             * endRevision= the latest (HEAD) revision of the repository.
             * 
             * the 5th parameter - a boolean flag changedPath - if true then for
             * each revision a corresponding SVNLogEntry will contain a map of
             * all paths which were changed in that revision.
             * 
             * the 6th parameter - a boolean flag strictNode - if false and a
             * changed path is a copy (branch) of an existing one in the
             * repository then the history for its origin will be traversed; it
             * means the history of changes of the target URL (and all that
             * there's in that URL) will include the history of the origin
             * path(s). Otherwise if strictNode is true then the origin path
             * history won't be included.
             * 
             * The return value is a Collection filled up with SVNLogEntry
             * Objects.
             */
            for (long i = 0; i < endRevision; i += 100) {
                if (i > endRevision) {
                    i = endRevision;
                }
                logEntries = repository.log(new String[] { "" }, null, i,
                        i + 100, true, true);
                logEntriesToSTDOUT(logEntries);
            }
        } catch (SVNException svne) {
            System.out.println("error while collecting log information for '"
                    + url + "': " + svne.getMessage());
            System.exit(1);
        }
    }

    private static void logEntriesToSTDOUT(Collection logEntries) {
        for (Iterator entries = logEntries.iterator(); entries.hasNext();) {
            /*
             * gets a next SVNLogEntry
             */
            SVNLogEntry logEntry = (SVNLogEntry) entries.next();
            System.out.println("---------------------------------------------");
            /*
             * gets the revision number
             */
            long revision = logEntry.getRevision();
            System.out.println("revision: " + revision);
            /*
             * gets the author of the changes made in that revision
             */
            String author = logEntry.getAuthor();
            System.out.println("author: " + author);
            /*
             * gets the time moment when the changes were committed
             */
            Date date = logEntry.getDate();
            System.out.println("date: " + date);
            /*
             * gets the commit log message
             */
            String message = logEntry.getMessage();
            System.out.println("log message: " + message);
            /*
             * displaying all paths that were changed in that revision; cahnged
             * path information is represented by SVNLogEntryPath.
             */
            if (logEntry.getChangedPaths().size() > 0) {
                System.out.println();
                System.out.println("changed paths:");
                /*
                 * keys are changed paths
                 */
                Set changedPathsSet = logEntry.getChangedPaths().keySet();

                for (Iterator changedPaths = changedPathsSet.iterator(); changedPaths
                        .hasNext();) {
                    /*
                     * obtains a next SVNLogEntryPath
                     */
                    SVNLogEntryPath entryPath = (SVNLogEntryPath) logEntry
                            .getChangedPaths().get(changedPaths.next());
                    /*
                     * SVNLogEntryPath.getPath returns the changed path itself;
                     * 
                     * SVNLogEntryPath.getType returns a charecter describing
                     * how the path was changed ('A' - added, 'D' - deleted or
                     * 'M' - modified);
                     * 
                     * If the path was copied from another one (branched) then
                     * SVNLogEntryPath.getCopyPath &
                     * SVNLogEntryPath.getCopyRevision tells where it was copied
                     * from and what revision the origin path was at.
                     */
                    System.out.println(" "
                            + entryPath.getType()
                            + "	"
                            + entryPath.getPath()
                            + ((entryPath.getCopyPath() != null) ? " (from "
                                    + entryPath.getCopyPath() + " revision "
                                    + entryPath.getCopyRevision() + ")" : ""));
                }
            }
        }
    }
}
