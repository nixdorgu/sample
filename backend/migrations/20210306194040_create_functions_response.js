
exports.up = function(knex) {
  return knex.raw(`
    CREATE TYPE practice.score_response AS (ease_factor NUMERIC(7,4), spacing INTEGER);

    CREATE FUNCTION practice.score_response(score INTEGER, spacing INTEGER, ease_factor NUMERIC(7,4))
        RETURNS practice.score_response
        AS $$
    DECLARE
        new_ease_factor NUMERIC(7, 4);
        new_days INTEGER;
    BEGIN
        IF score IS NULL OR score < 0 OR score > 3 THEN 
            score = 0;
        END IF;
        IF score = 0 THEN
            new_ease_factor = ease_factor;
            new_days = 0; 
        ELSE
            IF spacing = 0 then
                new_days = 1;
                new_ease_factor = 2.5;
            elsif spacing = 1 THEN 
                new_days = 3;
                new_ease_factor = ease_factor;
            ELSE
                new_ease_factor = ease_factor + (0.1 - (4 - score) * (0.08 + (4 - score) * 0.02));
                IF new_ease_factor < 1.3 THEN
                    new_ease_factor = 1.3;
                END IF;
                new_days = spacing * new_ease_factor;
            END IF;
        END IF;
        RETURN (new_ease_factor, new_days)::practice.score_response;
    END;
    $$
    language plpgsql
    IMMUTABLE
    SECURITY DEFINER;

  `);
};

exports.down = function(knex) {
  return knex.raw(`
    DROP FUNCTION practice.score_response(INTEGER, INTEGER, NUMERIC);
    DROP TYPE practice.score_response;
  `);
};
