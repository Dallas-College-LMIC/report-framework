# /rf-create-report-spec - Generate Data Specification from Stakeholder Request

## Purpose
Analyzes stakeholder request documents and generates comprehensive data specifications for report creation, using pyghtcast (Lightcast API) and censusdis-cli to intelligently identify relevant data sources and create structured queries.

## Usage
```
/rf-create-report-spec <request_file_path>
```

**Parameters:**
- `request_file_path`: Path to stakeholder request document (PDF, DOCX, TXT, MD)

## Behavioral Instructions

**Core Principle: Minimum Viable Specification**
- Focus ONLY on data needed to answer the core question
- Avoid comprehensive analysis unless explicitly requested
- Start with essential metrics, expand only if justified
- Prefer single datasets over multiple sources when possible

When this command is invoked:

1. **Parse the Request Document**
   - Read and analyze the stakeholder request file
   - Extract ONLY essential information:
     * The primary decision to be made
     * Minimum target definition (occupation/industry)
     * Required geographic scope (no more than necessary)
     * Timeline constraints
     * Core success criteria ONLY

2. **Intelligent Code Discovery**
   - Use `pyghtcast discover datasets` to identify relevant Lightcast datasets
   - Use `pyghtcast discover hierarchy` to find appropriate:
     * SOC codes for occupations mentioned
     * NAICS codes for industries referenced
     * MSA/FIPS codes for geographic areas
   - Use `census-discover variables` to find relevant Census variables for demographic context
   - Map natural language descriptions to technical identifiers

3. **Generate Comprehensive Data Specification**
   Create a structured document with these sections:

   ### Executive Summary
   - Brief description of the analysis objective
   - Key questions to be answered
   - Data sources and approach

   ### Data Sources
   - **Primary Source**: Lightcast API (formerly EMSI)
   - **Datasets**: List specific datasets (e.g., EMSI.us.Occupation, EMSI.us.Industry)
   - **Secondary Sources**: Census ACS, other complementary data

   ### Target Definitions
   - **Occupation Codes**: SOC codes with descriptions
   - **Industry Codes**: NAICS codes with descriptions
   - **Geographic Scope**: MSA/FIPS codes with area names
   - **Time Period**: Analysis years and projections

   ### Data Collection Queries
   Generate ONLY queries needed to answer the specific request:
   - Analyze what data is actually required to make the decision
   - Create the minimum number of queries to fulfill the request
   - Each query should directly support the stated objective
   - Avoid standard templates - tailor to the actual need

   For each query, specify:
   - Dataset name
   - Metrics to collect (only those needed for the decision)
   - Constraints (area, occupation, industry filters)
   - Purpose: How this query answers part of the core request

   ### Data Processing Requirements
   - Calculations needed (location quotient, supply-demand gap, etc.)
   - Geographic comparisons
   - Trend analysis
   - Quality checks and validation

   ### Deliverable Format
   - Executive dashboard specifications
   - Detailed tables requirements
   - Visualization needs
   - Data dictionary requirements

   ### Timeline
   - Estimated data collection time
   - Analysis and processing time
   - Report preparation timeline
   - Review and quality check time

   ### Data Limitations & Considerations
   - Coverage limitations
   - Seasonal variations
   - Economic disruptions (e.g., COVID impact)
   - Self-employment considerations
   - Gig economy factors

   ### Appendix: Query Code Examples
   - Python code using pyghtcast
   - Authentication setup
   - Constraint building examples
   - Data retrieval and basic processing

5. **Metric Selection Intelligence**
   Choose metrics based on what the request actually needs:
   - Read the request to understand what specific information supports the decision
   - Select ONLY metrics that directly answer the stakeholder's questions
   - Avoid comprehensive metric collection - focus on decision-relevant data
   - If wage analysis isn't mentioned in the request, don't include earnings metrics
   - If demographic breakdowns aren't requested, stick to total employment figures

6. **Geographic Intelligence**
   - For metro areas: Use MSA codes, suggest peer metro comparisons
   - For states: Include state and national comparisons
   - For local areas: Consider county/ZIP level data availability
   - Auto-suggest comparison areas based on size/characteristics

7. **Quality Assurance**
   - Verify all codes exist in current data versions
   - Check geographic level compatibility
   - Ensure metric availability for specified time periods
   - Flag potential data limitations upfront

8. **Output Generation**
   - Create a descriptive name for the request based on content analysis (e.g., "personal-training-certificate-evaluation", "healthcare-workforce-analysis")
   - Extract requestor name from the document (look for signatures, contact info, "from" fields)
   - Create folder in `reports/` directory: `{YYYY-MM-DD}_{requestor-name}_{request_name}/`
   - Example: `reports/2025-01-15_thomas-b_personal-training-certificate-evaluation/`
   - Save specification as `data_spec.md` in the created folder
   - Structure document with standard sections (executive summary, data sources, queries, etc.)
   - Include working Python code examples
   - Make ready for subsequent report generation phase

## Example Output Structure

The generated specification should include these sections:
- Executive Summary (objective and approach)
- Data Sources & Datasets (Lightcast, Census, etc.)
- Target Definitions (SOC/NAICS/geographic codes)
- Data Collection Queries (tailored to the specific request)
- Processing Requirements & Calculations
- Deliverable Format
- Timeline
- Limitations & Considerations
- Appendix: Query Code Examples (Python using pyghtcast)

## Error Handling
- If request file cannot be read, provide clear error message
- If no relevant codes can be found, suggest broader search terms
- If datasets are unavailable, suggest alternative approaches
- Validate all generated codes against actual API availability

## Integration Notes
- Uses both pyghtcast CLI and Python API
- Leverages censusdis-cli for metadata discovery
- Assumes LCAPI_USER and LCAPI_PASS environment variables are set
- Generated specifications are input for subsequent report generation commands
