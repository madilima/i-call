-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_schedulings" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "date" DATETIME NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "observations" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    CONSTRAINT "schedulings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_schedulings" ("created_at", "date", "email", "id", "name", "observations", "user_id") SELECT "created_at", "date", "email", "id", "name", "observations", "user_id" FROM "schedulings";
DROP TABLE "schedulings";
ALTER TABLE "new_schedulings" RENAME TO "schedulings";
CREATE INDEX "schedulings_user_id_idx" ON "schedulings"("user_id");
CREATE TABLE "new_user_time_intervals" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "week_day" INTEGER NOT NULL,
    "time_start_in_minutes" INTEGER NOT NULL,
    "time_end_in_minutes" INTEGER NOT NULL,
    "user_id" TEXT NOT NULL,
    CONSTRAINT "user_time_intervals_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_user_time_intervals" ("id", "time_end_in_minutes", "time_start_in_minutes", "user_id", "week_day") SELECT "id", "time_end_in_minutes", "time_start_in_minutes", "user_id", "week_day" FROM "user_time_intervals";
DROP TABLE "user_time_intervals";
ALTER TABLE "new_user_time_intervals" RENAME TO "user_time_intervals";
CREATE INDEX "user_time_intervals_user_id_idx" ON "user_time_intervals"("user_id");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE INDEX "accounts_user_id_idx" ON "accounts"("user_id");

-- CreateIndex
CREATE INDEX "sessions_user_id_idx" ON "sessions"("user_id");
